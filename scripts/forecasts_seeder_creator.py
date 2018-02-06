from __future__ import division
import csv
import os
import random
from collections import defaultdict

# Run from politico_api path

SEEDER_FILE = 'forecast_seeder.csv'
DELIMITER = ','
PARTIES = ['PAN', 'PCONV', 'PES', 'PH', 'PMC', 'PMOR', 'PNA', 'PPM', 'PRD', 'PRI', 'PSD', 'PT', 'PVEM']

if os.path.exists(SEEDER_FILE):
  os.remove(SEEDER_FILE)

seeder_file = open(SEEDER_FILE, 'wb')
seeder_writer = csv.writer(seeder_file, delimiter=DELIMITER)

header = True
states = defaultdict(list)
districts = defaultdict(list)
munis = defaultdict(list)

def distribute_probability_to_logits(n):
  discrete_probs = map(lambda x: random.randint(0, 1000), xrange(n))
  N = sum(discrete_probs)
  return map(lambda x: x / N, discrete_probs)

def average_prob(logits):
  pass


with open('secciones_simple.csv', 'rb') as secciones_file:
  secciones_reader = csv.reader(secciones_file, delimiter=DELIMITER)
  for row in secciones_reader:
    probs = distribute_probability_to_logits(len(PARTIES))
    if header:
      seeder_writer.writerow(['FORECAST_TYPE'] + row[:3] + row[4:] + PARTIES)
      header = False
      seeder_writer.writerow([0,0,0,0,0] + probs)
    else:
      seeder_writer.writerow([4] + row[:3] + row[4:] + probs)    
      states[row[0]].append(row[:3] + row[4:] + probs)
      districts[row[1]].append(row[:3] + row[4:] + probs)
      munis[row[0] + '-' + row[4]].append(row[:3] + row[4:] + probs)

  #for state in states:
  for state in states:
    seeder_writer.writerow([1] + [state, 0, 0, 0] + distribute_probability_to_logits(len(PARTIES)))    

  for muni_c in munis:
    state,  muni = muni_c.split('-')[0], muni_c.split('-')[1] 
    seeder_writer.writerow([2] + [state, 0, 0, muni] + distribute_probability_to_logits(len(PARTIES)))

  for district in districts:
    seeder_writer.writerow([3] + [0, district, 0, 0] + distribute_probability_to_logits(len(PARTIES)))    
