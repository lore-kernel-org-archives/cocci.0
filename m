From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 09 Mar 2014 08:01:53 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <alpine.DEB.2.02.1403082257440.2126@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <alpine.DEB.2.02.1403082257440.2126@localhost6.localdomain6>
Message-ID: <531C11E1.5090004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I find the use of the element "n" (the name in square brackets) not obvious from
>> the Coccinelle manual so far.
> 
> It is the number of elements that have been matched.

A part of my difficulty with interpretation of the grammar for the semantic
patch language came from this notation.

"metadecl ::= ...
            | parameter [list] ids ;
            | parameter list [ id ] ids ;
..."


Do square brackets indicate in one line that an information is optional while in
the other line they should be used as literals?


> What analysis do you want to do?

If I try out the following script ...

@initialize:python@
@@
import sys
result = []
mark = ['"', '', '"']
delimiter = '|'

def store_positions(fun, count, places):
    """Add source code positions to an internal list."""
    for place in places:
        fields = []
        fields.append(fun)

        fields.append(count)

        mark[1] = place.file.replace('"', '""')
        fields.append(''.join(mark))

        fields.append(place.line)
        fields.append(str(int(place.column) + 1))
        result.append(delimiter.join(fields))

@skeleton@
identifier fun;
parameter list [count] pl;
position pos;
@@
 fun at pos(pl)
 {
  ...
 }

@script:python collection depends on skeleton@
fun << skeleton.fun;
count << skeleton.count;
places << skeleton.pos;
@@
store_positions(fun, count, places)

@finalize:python@
@@
if result:
   result.insert(0, delimiter.join(("function", '"parameter count"', '"source
file"', "line", "column")))
   print("\r\n".join(result))
else:
   sys.stderr.write("No result for this analysis!\n")


... on this source code example, ...

void my_log(char const * text)
{
  /* Write something ... */
}

int my_safe_log(char const * text)
{
  if (!text)
    return 1;

  my_log(text);
  return 0;
}

char const * const my_message(void)
{
  return "Surprise!";
}

int my_status(void)
{
  return 1;
}

int my_addition(char a, char b)
{
  return a + b;
}

int main(void)
{
  struct my_operations
  {
    void (*log)(char const * t);
    int (*safe_log)(char const * t);
    char const * const (*get_message)(void);
    int (*is_ready)(void);
    int (*add)(char a, char b);
  } mo = {my_log, my_safe_log, my_message, my_status, my_addition}, * mop = &mo;

  char const * const x = mo.get_message();
  int y = mop->is_ready();
  y = mop->add(1, 2);
  y = mo.add(3, 4);
  mo.log(mo.get_message());
  mo.is_ready();
  my_safe_log(0);
  mo.safe_log(0);
  mop->safe_log(0);
}


... I get a result that is a bit interesting.

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --sp-file
list_function_parameters2.cocci ../Probe/f-ptr-test1.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: ../Probe/f-ptr-test1.c
function|"parameter count"|"source file"|line|column
main|1|"../Probe/f-ptr-test1.c"|30|5
my_log|1|"../Probe/f-ptr-test1.c"|1|6
my_message|1|"../Probe/f-ptr-test1.c"|15|20
my_safe_log|1|"../Probe/f-ptr-test1.c"|6|5
my_status|1|"../Probe/f-ptr-test1.c"|20|5
my_addition|2|"../Probe/f-ptr-test1.c"|25|5


I guess that I want to exclude matches for my use case where where the parameter
type is "void". I would like to show the distribution of parameter numbers in a
source code base.

Regards,
Markus
