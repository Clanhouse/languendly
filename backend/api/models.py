from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.utils.translation import gettext_lazy as _
from django.utils import timezone

class AccountUserManager(BaseUserManager):
    """Define a model manager for User model with no username field."""

    use_in_migrations = True

    def _create_user(self, email, password, **extra_fields):
        """Create and save a User with the given email and password."""
        if not email:
            raise ValueError('The given email must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        """Create and save a regular User with the given email and password."""
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        """Create and save a SuperUser with the given email and password."""
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(email, password, **extra_fields)


class Account(AbstractUser):
    username = None
    first_name = models.CharField(_("first name"), max_length=150, blank=True)
    last_name = models.CharField(_("last name"), max_length=150, blank=True)
    email = models.EmailField(_("email address"),
    unique=True,
    error_messages={
        "unique": _("A user with that email address already exists."),},
        )

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    objects = AccountUserManager()

    class Meta:
        verbose_name = _("account")
        verbose_name_plural = _("accounts")


class Word(models.Model):
    ENGLISH = 'ENG'
    GERMAN = 'GER'

    WORD_LANGUAGE = [
        (ENGLISH, 'English'),
        (GERMAN, 'German')
    ]

    BEGINER = 'A1'
    INTERMEDIATE = 'B1'

    WORD_LEVEL = [
        (BEGINER, 'Beginer'),
        (INTERMEDIATE, 'Intermediate')
    ]

    word = models.CharField(max_length=30)
    translation = models.CharField(max_length=30)
    language = models.CharField(choices=WORD_LANGUAGE, max_length=3)
    level = models.CharField(choices=WORD_LEVEL, max_length=2)
    description = models.TextField(blank=True, default='')

    class Meta:
        ordering = ['id']

