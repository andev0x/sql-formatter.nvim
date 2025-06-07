from setuptools import setup, find_packages

setup(
    name="nvim-sqlformat",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        "sqlparse>=0.4.4",
        "pynvim>=0.4.3",
    ],
    python_requires=">=3.8",
) 