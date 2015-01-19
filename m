From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Mon, 19 Jan 2015 09:36:20 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <C6562C4E-D1AB-4798-8491-2971C99349CF@gmail.com>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <alpine.DEB.2.10.1501182028570.3422@hadrien>
 <C6562C4E-D1AB-4798-8491-2971C99349CF@gmail.com>
Message-ID: <C5B87524-3D70-4937-9CB6-0A3CA1F72E62@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I?ve got lots of things installed through macports, and I?ve heard that there are problems if you mix both macports and brew in the same system. So, I?ll try to read about that a bit before trying to install with brew.

BTW, it?s a bit embarrassing, but your suggestion about brew made me check if there was a macports package for coccinelle. And there was, but failed to install too because of missing headers. I hadn?t even looked for it, because nothing is mentioned about macports/brew in the web page.

Thanks!

> On 19 Jan 2015, at 00:12, Jose Miguel Hernandez <jmiguel.hdez@gmail.com> wrote:
> 
> i think i was successful using homebrew on my Mac. http://brewformulas.org/Coccinelle
> http://brew.sh
> 
> Sent from my iPhone
> 
>> On 18/01/2015, at 01:29 p.m., Julia Lawall <julia.lawall@lip6.fr> wrote:
>> 
>>> On Sun, 18 Jan 2015, Eliseo Mart?nez wrote:
>>> 
>>> No luck. ./configure seems to run fine but make this error:
>>> 
>>> /opt/local/bin/ocamlc.opt -g  -I /Users/eliseo/projects/os/coccinelle/bundles/menhirLib/ -I /opt/local/lib/ocaml -I /opt/local/lib/ocaml/site-lib/pcre -I commons -I commons/ocamlextra -I ctl -I engine -I extra -I globals -I ocaml -I parsing_c -I parsing_cocci -I popl09 -I python -c main.ml
>>> /opt/local/bin/ocamlc.opt -g  -I /Users/eliseo/projects/os/coccinelle/bundles/menhirLib/ -I /opt/local/lib/ocaml -I /opt/local/lib/ocaml/site-lib/pcre -I commons -I commons/ocamlextra -I ctl -I engine -I extra -I globals -I ocaml -I parsing_c -I parsing_cocci -I popl09 -I python -custom -g     -ccopt -L/opt/local/lib -ccopt -lpcre -dllib -lpcre_stubs -cclib -lpcre_stubs -o spatch str.cma unix.cma bigarray.cma nums.cma /opt/local/lib/ocaml/dynlink.cma /opt/local/lib/ocaml/site-lib/pcre/pcre.cma commons/commons.cma globals/globals.cma ctl/ctl.cma parsing_cocci/cocci_parser.cma parsing_c/parsing_c.cma engine/cocciengine.cma popl09/popl.cma extra/extra.cma python/coccipython.cma ocaml/cocciocaml.cma flag_cocci.cmo cocci.cmo testing.cmo test.cmo main.cmo
>>> File "_none_", line 1:
>>> Error: Files commons/commons.cma(Common)
>>>      and /opt/local/lib/ocaml/stdlib.cma(Bytes)
>>>      make inconsistent assumptions over interface Bytes
>>> make[3]: *** [spatch] Error 2
>>> make[2]: *** [byte] Error 2
>>> make[1]: *** [all-dev] Error 2
>>> make: *** [all] Error 2
>>> 
>>> Anyone has seen that before?
>> 
>> The use of Bytes is new with this version.  I will ask someone to look
>> into it.  Just in case, could you try make clean before make?
>> 
>> thanks,
>> julia
>> 
>>> 
>>> Thanks,
>>> Eliseo.
>>> 
>>>> On 17 Jan 2015, at 23:09, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>> 
>>>> On Sat, 17 Jan 2015, Eliseo Mart?nez wrote:
>>>> 
>>>>> Hi,
>>>>> 
>>>>> Up to now, I?ve been using coccinelle in an Ubuntu virtual machine, running in my OSX Yosemite machine.
>>>>> Now I?d like to try installing it on OSX itself.
>>>>> As I don?t see anything about this on the website, I wanted to ask first.
>>>>> Has anybody managed to successfully install coccinelle on OSX?
>>>> 
>>>> Yes, I think it should be OK.  The only detail may be with PCRE (ocaml
>>>> library for regular expressions).  Some people reported that configure
>>>> correctly detected that they did not have pcre installed, but when it came
>>>> tie to link Coccinelle, pcre was expected.  So they had to install pcre.
>>>> 
>>>> julia
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
