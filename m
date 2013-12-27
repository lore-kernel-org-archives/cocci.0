From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 27 Dec 2013 10:46:34 +0100
Subject: [Cocci] simple scanner question
Message-ID: <20131227094634.GA10062@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


HI !

 Trying to scan for a problem that was recently found in the acpi code.

<snip>
static void advance_transaction(struct acpi_ec *ec, u8 status)
{
        unsigned long flags;
        struct transaction *t = ec->curr;

        spin_lock_irqsave(&ec->lock, flags);
        if (!t)
                goto unlock;
        if (t->wlen > t->wi) {
<snip>

 the problem being that there is a race beween assignment of *t and aquiring
 the lock in the ec structure.

 What I thought should do was:

@assign@
expression s,var;
position p1,p2,p3;
statement S1;
identifier func,member;
@@

...func at p1(...){
...
 var = s->member at p2;
...
 spin_lock_irqsave at p3(s->lock,...);
 if(!var)
  S1
 ...
}

@script:python@
p1 << assign.p1;
p2 << assign.p2;
p3 << assign.p3;
fn << assign.func;
@@

print "%s:%s possible assign without lock at lines %s (related ? lock at line %s)" % (p1[0].file,fn,p2[0].line,p3[0].line)

but this simply does not trigger in the above code snippet. 

 root@rtl15:/usr/src/3.12.5-rt7# spatch -sp_file race3.cocci drivers/acpi/ec.c
 init_defs_builtins: /usr/local/share/coccinelle/standard.h
 HANDLING: drivers/acpi/ec.c

Can someone point me to my missunderstanding of coccinelle ?

thx!
hofrat
