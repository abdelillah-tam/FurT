// Sign In exceptions
class InvalidEmailAuthException implements Exception{}
class UserDisabledAuthException implements Exception{}
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}
class UserNotLoggedInAuthException implements Exception{}

class GenericAuthException implements Exception{}