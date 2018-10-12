#!/bin/bash
set -e

export PATH="$HOME/miniconda/bin:$PATH"

make all
make python
mvn clean test -f java/pom.xml
make test
make rl_clientlib_test
cd test
./test_race_condition.sh
cd ..
make test_gcov --always-make
cd python
source activate test-python27
pip install pytest readme_renderer pandas
python setup.py check -mrs
python setup.py install
py.test tests
source deactivate
cd ..
