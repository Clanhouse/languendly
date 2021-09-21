from rest_framework import permissions

ADMIN_ONLY_METHODS = ('POST', 'DELETE', 'PUT')

class AdminOrReadOnly(permissions.BasePermission):
    """
    The request is authenticated as a admin, or is a read-only request.
    """

    def has_permission(self, request, view):
        return bool(
            request.method in ADMIN_ONLY_METHODS and request.user.is_staff and request.user or
            request.method=='GET' and request.user.is_authenticated and request.user
        )