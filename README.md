# Setting up TensorFlow 1.0 with Python 2.7 on AWS GPU-instance

## Description

`setup-aws-tensorflow.bash` installs the following things on the ec2 `g2.2xlarge` instance running Ubuntu 14.04:

- Required linux packages
- CUDA 7.5
- cuDNN v4
- Anaconda with Python 2.7
- formats and mounts partition /dev/xvdb as /home/ubuntu/nd013 


`setup-keras-research.sh` installs following things
- TensorFlow 1.0
- GPU usage tool `gpustat`


Original version was based on the blog post: <http://max-likelihood.com/2016/06/18/aws-tensorflow-setup/>.



## WARNING 

g2.2xlarge costs ~$500/month (really, i mean it), so use it very carefully

## /WARNING


## Usage

1. Create aws ec2 instance of ec2 `g2.2xlarge` instance running Ubuntu 14.04
2. On Step4 'Add Storage' set root volume size to 15GB
3. On Step4 'Add Storage' add new  EBS volume with 140GB size. It will be mounted as /dev/xvdb and we'll store training pictures there. 42GB of zip + unzipped 80GB, so 120GB is just bare minumum to make it work.
4. Do not forget to save your .pem file to access to box. let's say you named it 'nd013.pem'
5. ssh to your box using

```bash
ssh -i nd013.pem ubuntu@your_ec2_box_ip 
``` 


6. install git

```bash
sudo apt-get install git -y
```

7. clone this repo
```bash
git clone https://github.com/mungobungo/aws-tensorflow-setup.git
```

8. Run `setup_aws_tensorflow.bash` on the aws instance:

```bash
~/aws-tensorflow-setup/setup_aws_tensorflow.bash
```

9. wait for 5 minutes or so

10. Run `setup-keras-research.sh` on the aws instance:

```bash
~/aws-tensorflow-setup/setup-keras-research.sh
```

11. go to nd013 folder
```bash
cd ~/nd013
```

12. clone comma.ai repository there
```bash
git clone https://github.com/commaai/research.git
``` 

13. download training data
```
cd research
./get_data.sh
```

14. wait several hours until training data is downloaded

15. have fun )
