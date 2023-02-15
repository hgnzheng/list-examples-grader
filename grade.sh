# CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -f ListExamples.java ]]
then 
    echo "ListExamples.java found"
else
    echo "ListExamples.java not found"
    exit 1
fi

cp ../TestListExamples.java TestListExamples.java 
javac ListExamples.java > error-output.txt

cp -r ../lib lib
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
# cd student-submission 
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > output.txt

if grep -q output.txt; then
    echo "You got 100%"
else 
    echo "FAILURES!!!"
fi

grep "Tests run" output.txt > FAILURES.txt
