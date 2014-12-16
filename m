From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 16 Dec 2014 20:30:35 +0100
Subject: [Cocci] Determination for the number of named function
 parameters (with SmPL)
In-Reply-To: <547C4D11.1050206@users.sourceforge.net>
References: <547C4D11.1050206@users.sourceforge.net>
Message-ID: <5490885B.4030000@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Would you like to know how many named function parameters are used in the source files?

How do you think about to try the following semantic query approach out a bit more?

@initialize:python@
@@
import sys
import sqlalchemy
sys.stderr.write("\n".join( ("Using SQLAlchemy version:",
                             sqlalchemy.__version__) ))
sys.stderr.write("\n")
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker
engine = create_engine("sqlite:///:memory:", echo=False)
base = declarative_base()

class function(base):
   __tablename__ = "numbers"
   name = Column(String, primary_key=True)
   source_file = Column(String, primary_key=True)
   line = Column(Integer, primary_key=True)
   column = Column(Integer, primary_key=True)
   parameter_number = Column(Integer)
   
   def __repr__(self):
      return """<function(name='%s',
source_file='%s',
line='%s',
column='%s',
parameter_number='%s')>""" % (self.name,
                              self.source_file,
                              self.line,
                              self.column,
                              self.parameter_number)

configured_session = sessionmaker(bind=engine)
session = configured_session()
base.metadata.create_all(engine)

def store_number(fun, source, count):
    """Add an integer to an internal table."""
    for place in source:
       entry = function(name = fun,
                        source_file = place.file,
                        line = place.line,
                        column = int(place.column) + 1,
                        parameter_number = count)
       session.add(entry)

@counting_parameters@
identifier work;
parameter list[number] pl;
position pos;
type return_type;
@@
 return_type work at pos(pl)
 {
  ...
 }

@script:python collection@
fun << counting_parameters.work;
count << counting_parameters.number;
place << counting_parameters.pos;
@@
store_number(fun, place, count)

@finalize:python@
@@
session.commit()
from sqlalchemy import func
entries = session.query(func.count("*")).select_from(function).scalar()

if entries > 0:
   delimiter = "|"
   sys.stdout.write(delimiter.join( ("number", "incidence") ))
   sys.stdout.write("\r\n")
   for number, incidence in session.query(function.parameter_number,
                                          func.count("*")).group_by(function.parameter_number):
      sys.stdout.write(delimiter.join( (str(number), str(incidence)) ))
      sys.stdout.write("\r\n")
else:
   sys.stderr.write("No result for this analysis!\n")



elfring at Sonne:~/Projekte/Coccinelle/Probe> XX=$(date) && spatch.opt -timeout 12 -sp-file list_parameter_numbers2.cocci -dir /usr/src/linux-stable > list_parameter_numbers2.txt 2> list_parameter_numbers2-errors.txt ; YY=$(date) && echo "$XX * $YY"
Di 16. Dez 18:51:03 CET 2014 * Di 16. Dez 19:16:28 CET 2014
...
elfring at Sonne:~/Projekte/Coccinelle/Probe> cat list_parameter_numbers2.txt
number|incidence
0|46
1|161270
2|103405
3|55551
4|25947
5|9569
6|4907
7|1860
8|738
9|335
10|177
11|108
12|64
13|20
14|11
15|8
16|4
17|5
18|1
21|1
22|1


Do you find such an analysis result from the source files for Linux 3.18
(with the help of the software "Coccinelle 1.0.0-rc23") interesting
for further considerations?

Regards,
Markus
