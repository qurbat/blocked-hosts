# act-censorship
This repository houses a list of websites known to be blocked by ACT Fibernet. 

## Methodology
One of the web censorship techniques employed by ACT Fibernet is that of poisoning the DNS `A record` entry for each root domain present on their block list. The poisoned DNS record appears to so far consistently point to one partiular IP address, the knowledge of which becomes useful when querying a large list of hostnames with the intent of inferring a list of blocked hostnames.

```
tencent.com. 0 IN A 49.205.171.200
qq.com. 0 IN A 49.205.171.200
ucweb.com. 0 IN A 49.205.171.200
```

## Data

As a uniform list of suitable hostnames was not readily available, several publicly available domain name lists were collated and used as input. The collated list was further modified to exclude subdomains and duplicate entries.

1. **Top 1 million from [Alexa](http://s3.amazonaws.com/alexa-static/top-1m.csv.zip)**

2. **Top 10 million from [DomCop](https://www.domcop.com/files/top/top10milliondomains.csv.zip)**

3. **Collections released by [Domains Project](https://dataset.domainsproject.org)**

4. **List from [How India Censors the Web](https://github.com/kush789/How-India-Censors-The-Web-Data/blob/master/potentially_blocked_unique_hostnames.txt)**

The process used for extracting first level domains was not ideal, as a result of which a small portion of hostnames were accidentally omitted from the compiled list.

### Results

In total, `3592` individual hostnames [were found](https://github.com/qurbat/act-censorship/blob/main/compiled_block_list.txt) being blocked. Please note that this list of blocked hostnames is not complete or fully representative of all of the hostnames that might be blocked by ACT Fibernet at any given time.

### Source data
The lists made available by Alexa and DomCop contained more than half of the hostnames present in the final compiled list of blocked hostnames despite the comparitive difference in their sizes. Domains Project data was particularly useful for uncovering *obscure* blocked hosts. The list made available as part of the paper [How India Censors the Web](https://arxiv.org/abs/1912.08590) proved to be useful for further discovering obscure hostnames that did not feature in the other lists.

## Reproducibility

#### act-blocktest.sh

```
./act-blocktest.sh compiled_block_list.txt
```

**Note:** The script expects a response of `IN A 49.205.171.200` for identifying blocked hosts.

If you intend to run the script using the network of an Internet service provider other than ACT, you will have to modify the expected response for identifying a blocked host on [line 16](https://github.com/qurbat/act-censorship/blob/main/blocktest.sh#L16) accordingly.

#### MassDNS
[MassDNS](https://github.com/blechschmidt/massdns) can be used to query a sizeable number of hostnames with speed. The responses from these DNS queries can then be used to extraploate blocked hosts.

```
./massdns -r lists/act_resolver.txt -s 10000 -t A lists/10m_domain_sorted.txt > output/10m_dns_responses.txt
cat output/10m_dns_responses.txt | grep "POISONED_A_RECORD_HERE" > 10m_blocked.txt
```

## Notes

This repository was inspired by the paper *[How India Censors the Web](https://arxiv.org/abs/1912.08590)* authored by Kushagra Singh, Gurshabad Grover, and Varun Bansal. The primary intention behind this repository is to introduce some amount of transparency to the otherwise opaque processes associated with web censorship in India.

It is hoped that this data will be useful to those researching the scale and impact of web censorship in India.
