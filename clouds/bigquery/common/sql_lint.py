import sqlfluff
import sys

# Lint the sql files passed as input

scripts = sys.argv[1].split(' ')
ignored_files = sys.argv[3]
if ignored_files:
    with open(ignored_files, 'r') as ignored_file:
        ignored_scripts = ignored_file.read().split('\n')
    for ignored_script in ignored_scripts:
        scripts = list(filter (lambda x:not x.endswith(ignored_script) , scripts))

for script in scripts:
    content = ''
    with open(script, 'r') as file:
        content = file.read().replace('@@BQ_DATASET@@', '_sqlfluffdataset_').replace('@', '_sqlfluff_')
    fixed_content = (
        sqlfluff.fix(content, dialect = 'bigquery', config_path = sys.argv[2])
        .replace('_sqlfluffdataset_', '@@BQ_DATASET@@')
        .replace('_SQLFLUFFDATASET_', '@@BQ_DATASET@@')
        .replace('_sqlfluff_', '@')
        .replace('_SQLFLUFF_', '@')
    )
    with open(script, 'w') as file:
        file.write(fixed_content)
