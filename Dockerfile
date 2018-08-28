FROM nhdocker/centos
MAINTAINER NGUYEN VAN HUONG "nguyenhuong791123@gmail.com"

ENV PYTHON_VERSION "3.6.1"

RUN yum install -y gcc python-pip python-dev build-essential python-virtualenv

COPY . /var/www

# Python3.6インストー
# https://www.python.jp/install/centos/index.html
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y \
    python36u \
    python36u-devel \
    python36u-pip \
 && yum clean all \
 && ln -sf /usr/bin/python3.6 /usr/bin/python3 \
 && ln -sf /usr/bin/pip3.6 /usr/bin/pip3 \
 && pip3 install --upgrade pip


#ENV PATH "/usr/local/bin:${PATH}"

# pipインストール(最新版)
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

# readlineインストール
#RUN pip install readline

# virtualenvインストール
RUN pip3 install virtualenv

# uwsgiインスト
RUN pip3 install uwsgi

WORKDIR /var/www
RUN virtualenv app
RUN /bin/bash -c "source app/bin/activate; pip3 install -r requirements.txt"

CMD ["uwsgi", "--ini", "/var/www/uwsgi.ini"]
