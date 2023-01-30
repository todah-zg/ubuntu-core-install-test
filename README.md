# Simple script to create a custom Ubuntu core image

The included customized Ubuntu core model was created as:
1. download the official model assertion json from [Snapcore repository](https://github.com/snapcore/models/blob/master/ubuntu-core-22-amd64.json) 
2. replace the "authority-id" and "brand-id" with my "developer-id"
3. create and register a snapcraft key
4. replace the "timestamp" with the current system timestamp
5. sign the model assertion using `snap sign -k keyname < my-ubuntu-22-core.json > my-ubuntu-22-core.model`

## Issues
Despite many efforts, I was not able to create an image that would skip the initial configuration (associating the device with Ubuntu SSO) and still allow user login. I tried to solve this problem using the `--cloud-init cloud.conf` argument with `ubuntu-image` command but I must have misconfigured something or otherwise encountered a bug as I always hit the _"Error: Error preparing image: cannot support with UC20 model requested customizations: cloud-init user-data"_ message. The same cloud config was supposed to handle showing the 'hello world' message as well.