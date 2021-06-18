package Schema::Result::Request;

use header;
use base qw(DBIx::Class::Core);

__PACKAGE__->table("requests");
__PACKAGE__->add_columns(qw(id account_id amount derivation_index status ts));
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(account => "Schema::Result::Account", "account_id");
