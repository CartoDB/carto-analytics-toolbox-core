import os
import sys


python_util_path = os.path.dirname(os.path.realpath(__file__))
output_file = os.path.join(python_util_path, '..', '..', 'modules', 'build', 'sql', 'drop.sql')
schema = None


if len(sys.argv) > 1:
    output_file = sys.argv[1]
    if len(sys.argv) > 2:
        schema = sys.argv[2]


def get_uninstall_for_module(module_path, queries_list):
    database = schema
    database = 'default' if database is None else database
    _, _, functions = next(os.walk(module_path))
    # FIXME: should we read the SQL file, extract the @@DB_SCHEMA@@.function_name
    # frrom the definition and substitute the schema?
    for function in functions:
        if not function.endswith('.sql'):
            continue
        function_name = function[:-4]
        queries_list.append(f'DROP FUNCTION IF EXISTS {database}.{function_name};')


def write_queries(final_query):
    with open(output_file, 'w') as file:
        file.write(final_query)


if __name__ == '__main__':
    sql_path = os.path.join(python_util_path, '..', '..', 'modules', 'sql')
    modules = os.listdir(sql_path)
    # We filter paths that aren't a directory
    modules = list(filter(lambda x: os.path.isdir(os.path.join(sql_path, x)), modules))
    queries_list = []
    for module in modules:
        module_path = os.path.join(sql_path, module)
        get_uninstall_for_module(module_path, queries_list)
    final_query = '\n'.join(queries_list)
    write_queries(final_query)
