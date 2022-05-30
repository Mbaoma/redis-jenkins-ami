## Bake Jenkins and Redis into an AMI

- Install Packer on your system:

```bash
$ brew tap hashicorp/tap
$ brew install hashicorp/tap/packer
```

- Configure your AWS secrets:

```bash
$ export AWS_ACCESS_KEY_ID="VALUE"           
$ export AWS_SECRET_ACCESS_KEY="VALUE"
```

- Build your AMI:

```bash
$ packer build .
Build 'learn-packer.amazon-ebs.ubuntu' finished after 10 minutes 21 seconds.

==> Wait completed after 10 minutes 21 seconds

==> Builds finished. The artifacts of successful builds are:
--> learn-packer.amazon-ebs.ubuntu: AMIs were created:
us-west-2: ami-0e59750cbfd3e8d98

```

- SSH into your EC2 instance.
Note: In your security group, enable the following traffic: 

-- TCP on port 8080 

-- HTTPS 

-- SSH

- Restart your Jenkins server before navigating to the browser to access Jenkins.

- Add change ```supervised no``` to ```supervised systemd``` to the file ```nano /etc/redis/redis.conf```: 
```bash
$ sudo nano /etc/redis/redis.conf
$ sudo systemctl restart redis.service
```

- Restart your services
```bash
$ sudo systemctl status redis
```

<img width="562" alt="image" src="https://user-images.githubusercontent.com/49791498/171040783-e35419dd-0c8d-4144-a2db-7ae4d158da76.png">

```bash
$ sudo systemctl status jenkins
```

<img width="567" alt="image" src="https://user-images.githubusercontent.com/49791498/171040847-0e8c88b5-fa9b-4b9a-8801-33fb401c6c8d.png">

- Test Redis
```bash
$ redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> set test "Redis AMI"
OK
127.0.0.1:6379> get test
"Redis AMI"
127.0.0.1:6379> exit
```

- Test Jenkins. Navigate to http://<ec2-ip>:8080 on your browser.
<img width="907" alt="image" src="https://user-images.githubusercontent.com/49791498/171041307-07f53097-3b3c-4f16-b049-353cd25c1e81.png">