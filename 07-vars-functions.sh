#!/bin/bash

SAMPLE(){
echo "in the function"
echo "scriptname is $0"
echo "first arg passed $1"
echo "second arg passed $2"
}

echo "out the function"
echo "scriptname is $0"
echo "first arg passed $1"
echo "second arg passed $2"

SAMPLE $1 $2
