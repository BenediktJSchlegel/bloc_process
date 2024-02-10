/// This error indicates that a `MultiChannelProcessBloc` received an event
/// that has multiple applicable `BlocChannel` objects defined.
///
/// Make sure to correctly subtype your events
class AmbiguousBlocEventError extends Error {}
