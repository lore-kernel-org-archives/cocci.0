From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Mon, 1 Dec 2014 11:37:06 +0100
Subject: [Cocci] How to use coccinelle as a kind of grep -l ?
In-Reply-To: <547C4194.5040002@inria.fr>
References: <547C3F10.4000307@inria.fr> <547C4194.5040002@inria.fr>
Message-ID: <20141201103706.GA27923@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 01 Dec 2014, Francois Berenger wrote:

> On 12/01/2014 11:12 AM, Francois Berenger wrote:
>> Hello,
>>
>
> Instead of applying ...
>
>> Inside of applying any patch, I need to use coccinelle
>> in order to detect certain C files that match a given pattern
>> in a source code tree.
>>
>> Is it possible to use coccinelle for that, how?
>>
>
here is a simple (hopefuly correct) example of a scanner - that will look
for inbalanced use of spinlocks and bh disable/enable - it reports one 
line per file that matches giving the name and line-numbers of the 
potentially inballanced calls. 


@r1@                                                                            
identifier f;
expression E;
position p1,p2,p3;
@@
f(...) {
<...
(
spin_lock_bh(E)@p1;
...
spin_unlock(E)@p2;
...
local_bh_enable()@p3;
|
local_bh_disable()@p2;
...
spin_lock(E)@p3;
...
spin_unlock_bh(E)@p1;
)
...>
}

@script:python@
p1 << r1.p1;
p2 << r1.p2;
p3 << r1.p3;
@@
print "file:%s at lines %s %s %s" % (p1[0].file,p1[0].line, p2[0].line, p3[0].line)


put this in a file called scan.cocci and running with the below command 
gives me:

hofrat at debian:/usr/src/linux-next$ spatch --cocci-file /tmp/scan.cocci --dir net/core/
HANDLING: net/core/datagram.c
HANDLING: net/core/netpoll.c
...
HANDLING: net/core/sock.c
file:net/core/sock.c at lines 2396 2406 2411
file:net/core/sock.c@lines 2346 2350 2355
...


thx!
hofrat
