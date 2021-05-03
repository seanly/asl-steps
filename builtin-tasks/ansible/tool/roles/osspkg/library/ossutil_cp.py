#!/usr/bin/env python
# coding=utf-8

from ansible.module_utils.basic import *


def main():
    fields = {
            "access_key": {"required": True, "type": "str"},
            "secret_key": {"required": True, "type": "str" },
            "object": {"required": True, "type": "str"},
            "options": {"default": "", "type": "str" },
            "endpoint": {"required": True, "type": "str" },
            "dest": {"required": True, "type": "str" },
            "executable": {"required": False, "default": "/usr/bin/ossutil", "type": "str"}
            }

    module = AnsibleModule(argument_spec=fields)
    params = module.params
    ak = params["access_key"]
    sk = params["secret_key"]
    object_path = params["object"]
    options = params["options"]
    endpoint = params["endpoint"]
    dest = params["dest"]
    ossutil = params["executable"]

    cmd = [ossutil, '-i', ak, '-k', sk, '-e', endpoint, 'cp', object_path, dest, options]
    rc, out, err = module.run_command(cmd)

    if rc:
        module.fail_json(msg=err, stdout=out)
    else:
        module.exit_json(changed=True, stdout=out, stderr=err)


if __name__ == '__main__':
    main()
