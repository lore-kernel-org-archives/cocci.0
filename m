From: mstefani@redhat.com (Michael Stefaniuc)
Date: Wed, 7 Dec 2016 13:19:58 +0200
Subject: [Cocci] Comparing SmPL script constraints with direct regular
 expression interface
In-Reply-To: <ed5866d1-5f07-ec95-34a4-8a6f08327920@users.sourceforge.net>
References: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
 <19d8e848-da35-10af-6773-deab88137852@users.sourceforge.net>
 <alpine.DEB.2.10.1612021441470.3056@hadrien>
 <55445a2c-87c9-3794-4dee-5a006b6d1029@users.sourceforge.net>
 <alpine.DEB.2.10.1612021456580.3056@hadrien>
 <8e4a9ea0-9bb4-740e-a3d7-a434eb7cdcb6@users.sourceforge.net>
 <alpine.DEB.2.10.1612021526560.3056@hadrien>
 <ed5866d1-5f07-ec95-34a4-8a6f08327920@users.sourceforge.net>
Message-ID: <b4aa95fc-30c9-121a-d806-e0818e98f4a4@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/02/2016 10:48 PM, SF Markus Elfring wrote:
>> Why not just define a python function that you can call in a script to do
>> your big regexp for you?
> 
> Would any more developers and reviewers like to extend a source code analysis
> approach with a regular expression (or other data structure) like the following?
Why would you want to use that?
Just use the regexp directly, e.g.
identifier action1 = "regexp";
I'm using big regexp'es that way. Yes, I do find the perl style compact
regexp easier to read.

And for more specialized stuff I'm passing the identifier through a
python rule for further filtering.


bye
	michael

> 
> SmPL script example:
> 
> @initialize:python@
> @@
> import re
> compiled = re.compile("""^
> (?:
>    k(?:
>        [cmz]alloc
>     |  (?:m(?:
>               alloc_array
>            |  em(?:
>                    _cache_alloc(?:_node)?
>                 |  dup
>                 )
>            )
>        |  zalloc_node
>        )
>     |  str(?:
>              dup(?:_const)?
>           |  ndup
>           )
>     )
> |  of_find_matching_node
> # Alternation placeholder
> )$""", re.VERBOSE)
> 
> def is_selected(id):
>     match = compiled.search(id)
>     if match:
>         return True
>     else:
>         return False
> 
> @find_too_late_checking@
> expression assign1, assign2, ex1, ex2;
> identifier action1: script:python() { is_selected(action1) },
>            action2: script:python() { is_selected(action2) },
>            work;
> statement is, es;
> type return_type;
> @@
>  return_type work(...)
>  {
>  ... when any
> *ex1 = action1(...);
>  ex2 = action2(...);
>  ... when any
>      when != (ex1 = assign1)
>      when != (ex2 = assign2)
>  if (
> *      \( !(ex1) \| (ex1) == NULL \)
>     || \( !(ex2) \| (ex2) == NULL \)
>     || ...)
>     is
>  else
>     es
>  ... when any
>  }
> 
