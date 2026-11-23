"""Railway wrapper for Hola-Calendar: on first boot, open the store (which seeds the
superadmin + three sample accounts and a sample project), set superadmin's password from
HOLA_ADMIN_PASSWORD, then hand over to the unmodified server.py."""
import os, sys
from pathlib import Path

db = Path(os.environ.get('WORK_CALENDAR_DB', '/data/work-calendar.sqlite3'))
db.parent.mkdir(parents=True, exist_ok=True)
marker = db.parent / '.railway-admin-password-set'
pw = os.environ.get('HOLA_ADMIN_PASSWORD', '')
if pw and not marker.exists():
    sys.path.insert(0, '/app')
    import server
    store = server.Store(str(db))
    store.set_password('superadmin', pw)
    store.close()
    marker.touch()
    print('[railway] superadmin password set from HOLA_ADMIN_PASSWORD (first boot)', flush=True)
os.execvp(sys.executable, [sys.executable, '/app/server.py'])
