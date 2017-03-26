package Jobeet::Schema::Result::Something;

__PACKAGE__->table('jobeet_something');

__PACKAGE__->add_columns(
    json_column1 => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },

    json_column2 => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
);

__PACKAGE__->inflate_json_column(qw/json_column1 json_column2/);

1;
