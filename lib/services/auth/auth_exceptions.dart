// Sign In exceptions
class InvalidEmailAuthException implements Exception{}
class UserDisabledAuthException implements Exception{}
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}
class UserNotLoggedInAuthException implements Exception{}


// Register exceptions
class EmailAlreadyInUseAuthException implements Exception{}
class WeakPasswordAuthException implements Exception{}


class GenericAuthException implements Exception{}