from fabric.api import *
import json
import boto3
import botocore
import paramiko

key = paramiko.RSAKey.from_private_key_file('/home/aditya/Desktop/installation/final/folder/DNIF-V9-BETA.pem')
# client = paramiko.SSHClient()
# client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# client.connect(hostname="65.0.101.62", username="ubuntu", pkey=key)
obj = json.load(open('hosts.json'))

env.roledefs = {
    'ALL': [obj['CORE'][0]['host'],
            obj['LC'][0]['host'],
            obj['DL'][0]['host'],
            obj['DL'][1]['host'],
            obj['AD'][0]['host']],
    'CORE': [obj['CORE'][0]['host']],
    'LC': [obj['LC'][0]['host']],
    'DL': [obj['DL'][0]['host'], obj['DL'][1]['host']],
    'AD': [obj['AD'][0]['host']]
}
env.key_filename = [
    '/home/aditya/Desktop/installation/final/folder/DNIF-V9-BETA.pem']
data = obj['CORE'][0]['host'][7:]

@roles('ALL')
def copy_docker():
    put('servicetest-v9.sh', '/var/tmp/')
    #run('bash /var/tmp/servicetest-v9.sh')

@ roles('CORE')
def copy_CORE():
    run('uname -r')
    run('docker load < core_0.0.10.tar.gz')
    put('core.sh', '/var/tmp/')
    run('bash /var/tmp/core.sh ' + data)


@ roles('LC')
def copy_LC():
    interface = obj['LC'][0]['conf']['eth']
    run('hostname')
    run('docker load < lc_0.0.7.tar.gz')
    put('lc.sh', '/var/tmp/')
    run('bash /var/tmp/lc.sh ' + interface)


@ roles('DL')
def copy_DL():
    interface = obj['DL'][0]['conf']['eth']
    run('docker load <  dl_0.0.10.tar.gz')
    put('dl.sh', '/var/tmp/')
    run('bash /var/tmp/dl.sh ' + data + ' ' + interface)
    run('hostname')


@ roles('AD')
def copy_AD():
    run('docker load < ad_0.0.10.tar.gz')
    put('ad.sh', '/var/tmp/')
    run('bash /var/tmp/ad.sh ' + data)
    run('hostname')


@ task
def deploy():
    # execute(copy_docker)
    execute(copy_CORE)
    execute(copy_LC)
    execute(copy_DL)
    execute(copy_AD)
