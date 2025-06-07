# Copyright (c) 2025 Anvndev
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# File: python/sqlformat.py

from typing import Optional, Union, cast

import sqlparse
import vim


def format_sql(
    sql: str,
    indent: int,
    keyword_case: Optional[str],
    line_width: int = 80,
) -> str:
    """Format SQL code using sqlparse.

    Args:
        sql: SQL code to format
        indent: Number of spaces for indentation
        keyword_case: 'upper', 'lower', or None for keyword case
        line_width: Maximum line width for wrapping

    Returns:
        Formatted SQL string

    Raises:
        ValueError: If input parameters are invalid
    """
    try:
        vim.command('echo "Formatting SQL..."')

        # Validate inputs
        if not isinstance(indent, int) or indent < 0:
            raise ValueError("Indent must be a positive integer")
        if keyword_case not in ["upper", "lower", None]:
            raise ValueError("Keyword case must be 'upper', 'lower', or None")
        if not isinstance(line_width, int) or line_width < 0:
            raise ValueError("Line width must be a positive integer")

        # Format the SQL
        formatted = cast(str, sqlparse.format(
            sql,
            reindent=True,
            indent_width=indent,
            keyword_case=keyword_case,
            wrap_after=line_width,
        ))

        vim.command('echo "SQL formatting complete"')
        return formatted

    except Exception as e:
        error_msg = f"SQL formatting failed: {str(e)}"
        vim.command(f'echoerr "{error_msg}"')
        return sql  # Return original SQL on error
