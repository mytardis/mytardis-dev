# pylint: disable=wildcard-import,unused-wildcard-import
from tardis.default_settings import *  # noqa # pylint: disable=W0401,W0614
import logging  # pylint: disable=wrong-import-order

DEBUG = True

SYSTEM_LOG_LEVEL = logging.DEBUG
MODULE_LOG_LEVEL = logging.DEBUG

SECRET_KEY = "z4^43doy-4x*u5j&dpv2xx)#hux2lg*urh4&-#80(jl40u5ogh"

DATABASES = {
    'default': {
        'ENGINE':   "django.db.backends.postgresql_psycopg2",
        'NAME':     "postgres",
        'USER':     "user",
        'PASSWORD': "password",
        'HOST':     "db",
        'PORT':     "5432",
    }
}

DEFAULT_STORAGE_BASE_DIR = "/var/store/"

LDAP_USE_TLS = False
LDAP_URL = "ldap://ldap:389/"
LDAP_ADMIN_USER = "cn=admin,dc=mytardis,dc=org"
LDAP_ADMIN_PASSWORD = "password"

LDAP_USER_LOGIN_ATTR = "uid"
LDAP_USER_ATTR_MAP = {"givenName": "first_name", "sn": "last_name", "mail": "email"}
LDAP_GROUP_ID_ATTR = "cn"
LDAP_GROUP_ATTR_MAP = {"description": "display"}

LDAP_BASE = 'dc=mytardis, dc=org'
LDAP_USER_BASE = 'ou=People, ' + LDAP_BASE
LDAP_GROUP_BASE = 'ou=Group, ' + LDAP_BASE

NEW_USER_INITIAL_GROUPS = ['test-group']

AUTH_PROVIDERS = (
    ('localdb', 'Local DB', 'tardis.tardis_portal.auth.localdb_auth.DjangoAuthBackend'),
    ('ldap', 'LDAP', 'tardis.tardis_portal.auth.ldap_auth.ldap_auth')
)

INSTALLED_APPS += ('tardis.apps.mydata',)
# INSTALLED_APPS += ('haystack',)

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }
}

TEMPLATES[0]['OPTIONS'].update({
    'loaders': [
        'django.template.loaders.filesystem.Loader',
        'django.template.loaders.app_directories.Loader',
    ],
})