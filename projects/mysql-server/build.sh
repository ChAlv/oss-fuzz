
#!/bin/bash -eu
# Copyright 2018 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

cd mysql-server
git pull origin fuzzing_stmt_prepare

mkdir build
cd build
cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$WORK -DWITH_SSL=system -DDISABLE_SHARED=0 -DFUZZING=1 #Il y a aussi DWITHOUT_SERVER à considérer...
make GenError -j$(nproc)
make fuzzing_stmt_prepare -j$(nproc)
make fuzz_stmt_prepare -j$(nproc)

rm $SRC/mysql-server/build/bin/comp_err
cp $SRC/mysql-server/build/bin/* $OUT
