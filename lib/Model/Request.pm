package Model::Request;

use Moose;
use Crypt::Misc qw(random_v4uuid);
use Types;

use header;

with 'Model';

use constant {
	STATUS_AWAITING => 'awaiting',
	STATUS_PENDING => 'pending',
	STATUS_CALLBACK_FAILED => 'callback_failed',
	STATUS_COMPLETE => 'complete',
	STATUS_TIMEOUT => 'timeout',
};

# 14 days
use constant TTL => 60 * 60 * 24 * 14;

has 'id' => (
	is => 'ro',
	isa => Types::Uuid,
	default => sub { random_v4uuid },
);

has 'account_id' => (
	is => 'ro',
	isa => Types::Uuid,
	required => 1,
);

has 'amount' => (
	is => 'ro',
	isa => Types::PositiveInt,
	required => 1,
);

has 'derivation_index' => (
	is => 'ro',
	isa => Types::PositiveOrZeroInt,
);

has 'status' => (
	is => 'ro',
	isa => Types::Str,
	default => sub { STATUS_AWAITING },
);

has 'ts' => (
	is => 'ro',
	isa => Types::DateTime,
	coerce => 1,
	default => sub { time },
);

sub is_awaiting ($self)
{
	return $self->status eq STATUS_AWAITING;
}

sub is_pending ($self)
{
	return $self->status eq STATUS_PENDING;
}

sub is_callback ($self)
{
	return $self->status eq STATUS_CALLBACK_FAILED;
}

sub is_complete ($self)
{
	return $self->status eq STATUS_COMPLETE;
}

__PACKAGE__->_register;
