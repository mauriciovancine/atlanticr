fix_encoding <- function(data, source_encoding = "",
                         target_encoding = "UTF-8") {

    fixed_data <- data
    report <- list()
    counter <- 1L

    # Identify character columns
    character_columns <- names(data)[
        vapply(data, is.character, logical(1))
    ]

    for (column_name in character_columns) {

        values <- data[[column_name]]

        # Identify invalid strings
        invalid_strings <- vapply(seq_along(values), function(i) {

            if (is.na(values[i])) return(FALSE)

            tryCatch({
                nchar(values[i], type = "width")
                FALSE
            }, error = function(e) TRUE)

        }, logical(1))

        invalid_rows <- which(invalid_strings)

        # Record problematic values
        if (length(invalid_rows) > 0) {

            for (row_index in invalid_rows) {

                original_value <- values[row_index]

                fixed_value <- tryCatch(
                    iconv(
                        original_value,
                        from = source_encoding,
                        to = target_encoding,
                        sub = NA
                    ),
                    error = function(e) NA_character_
                )

                report[[counter]] <- data.frame(
                    column = column_name,
                    row = row_index,
                    original_value = original_value,
                    fixed_value = fixed_value,
                    stringsAsFactors = FALSE
                )

                counter <- counter + 1L

                # Replace only when conversion succeeds
                if (!is.na(fixed_value)) {
                    values[row_index] <- fixed_value
                }
            }
        }

        # Convert remaining strings to UTF-8
        converted_values <- iconv(
            values,
            from = source_encoding,
            to = target_encoding,
            sub = NA
        )

        # Preserve original values when conversion fails
        conversion_failures <- !is.na(values) &
            is.na(converted_values)

        converted_values[conversion_failures] <-
            values[conversion_failures]

        fixed_data[[column_name]] <- enc2utf8(converted_values)
    }

    # Combine correction reports
    if (length(report) > 0) {
        report <- do.call(rbind, report)
    } else {
        report <- data.frame(
            column = character(),
            row = integer(),
            original_value = character(),
            fixed_value = character()
        )
    }

    # Check for remaining invalid strings
    remaining_issues <- list()

    for (column_name in character_columns) {

        values <- fixed_data[[column_name]]

        invalid_rows <- which(vapply(seq_along(values), function(i) {

            if (is.na(values[i])) return(FALSE)

            tryCatch({
                nchar(values[i], type = "width")
                FALSE
            }, error = function(e) TRUE)

        }, logical(1)))

        if (length(invalid_rows) > 0) {
            remaining_issues[[column_name]] <- invalid_rows
        }
    }

    # Return results
    list(
        data = fixed_data,
        report = report,
        remaining_issues = remaining_issues
    )
}
