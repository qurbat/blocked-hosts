#!/usr/bin/python

import io
import tldextract
import sys

infile = sys.argv[1]

def extract(infile):
    with io.open(infile) as f:
        for line in f:
            domain = line.strip('\n')
            extracted = tldextract.extract(domain)
            if extracted.registered_domain:
                print("{}".format(extracted.registered_domain))

if __name__ == '__main__':
    extract(infile)