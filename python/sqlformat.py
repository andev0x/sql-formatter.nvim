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

import sqlparse


def format_sql(sql):
    """
    Format SQL code with fixed style: 2-space indent, uppercase keywords.
    
    Args:
        sql (str): SQL code to format
    Returns:
        str: Formatted SQL
    """
    return sqlparse.format(
        sql,
        reindent=True,
        indent_width=2,
        keyword_case='upper',
        wrap_after=80
    )
