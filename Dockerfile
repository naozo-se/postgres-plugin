# postgresのバージョン14最新
from postgres:14

# パッケージ更新＆パッケージのビルドで必要なもの
RUN apt-get update && apt-get install -y \
    git \ 
    make \ 
    gcc \
    postgresql-server-dev-14
# 必要なパッケージのインストール

# ------ pg_ivm導入
# git展開フォルダ
WORKDIR /tmp
# git で取得
RUN git clone https://github.com/sraoss/pg_ivm
# フォルダ移動
WORKDIR /tmp/pg_ivm
# make & install
RUN make USE_PGXS=1 
RUN make USE_PGXS=1 install

# EXTENTION登録SQLをコピー
COPY ./docker-entrypoint-initdb.d/90_pg_ivm.sql /docker-entrypoint-initdb.d
# (一応)ディレクトリはデフォルトに戻す
WORKDIR /

# 使わないので削除
RUN apt-get purge -y \
    git \ 
    make \ 
    gcc \
    postgresql-server-dev-14

RUN rm -rf /tmp/pg_ivm

# yml経由で .env の定義値を受け取り
# ARG PG_GID=${PG_GID}
# ARG PG_UID=${PG_UID}
# ARG PG_USERNAME=${PG_USERNAME}
# ARG PG_GROUPNAME=${PG_GROUPNAME}
# ARG HOST_PATH=${HOST_PATH}


# RUN groupmod -n $PG_GROUPNAME postgres
# RUN groupmod -g $PG_GID postgres
# RUN usermod -l $PG_USERNAME postgres
# RUN usermod -u $PG_UID postgres

# RUN rm -rf $HOST_PATH
# RUN mkdir -p $HOST_PATH
# RUN chmod -R 777 $HOST_PATH 
# RUN chown -R $PG_GID:$PG_UID /var/lib/postgresql
# RUN chown -R $PG_GID:$PG_UID $HOST_PATH

# RUN ls -al $HOST_PATH

# RUN chmod -R 755 $HOST_PATH 
# RUN chown -R 1000:1000 /var/run/postgresql

# USER $PG_USERNAME

# WORKDIR $HOST_PATH
