From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Wed, 16 Nov 2016 09:54:52 +0000
Subject: [Cocci] Help in interpreting results
In-Reply-To: <alpine.DEB.2.10.1611161043440.3153@hadrien>
References: <2236FBA76BA1254E88B949DDB74E612B41C009A9@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611151215240.3153@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B41C00A21@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611151335540.3153@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B41C0E608@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611161043440.3153@hadrien>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C0E631@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> >You may want to run coccinelle/scripts/idutils_index.sh in your code base.
> >Then if you use the argument --use-idutils it will select the relevant files up front from the index and be even more >efficient.  Skipping means that it essentialy did a grep and didn't find anything.  If the argument after --use-idutils does >not begin with -, it will think that it is the name of the index.  The easiest is to just put --use-idutils last.
>
> Thank you for the suggestion! I will try this out. However, I seem to have a different problem that the rule doesn't behave as I would think it should and enabling debug doesn't tell terribly much.
>
> My rule is now this:
>
> @r1 exists@
> identifier a, x;
> position p1, p2;
> identifier fname1 =~ ".*$free.*$";
> identifier fname2 =~ ".*$kfree_.*$";
> @@
>
> (
>  atomic_dec_and_test at p1(&a->x)
> |
>  atomic_long_dec_and_test at p1(&a->x)
> |
>  atomic64_dec_and_test at p1(&a->x)
> |
>  local_dec_and_test at p1(&a->x)
> )
> ...
> (
>  kfree at p2(a);
> |
>  fname1 at p2(a | (a, ...));

>I have the impression that you mean for the above to be a disjunction.
>But it is being interpreted as a bit or operation.  If you want to put a disjunction inline, you need \( \| \).
>But disjunction is not actually supported on an argument list, so it wouldn't help in this case.  Actually what you want is just:

>fname1 at p2(a, ...);

>Coccinelle will be ok with matching the ", ..." to nothing if there is only one argument.

I tried this before (and quite many other ways I would imagine grammar can do), but it didn't change anything. 
Still the clear cases that I mentioned are not detected. 

>julia

> |
>  fname2 at p2(a | (a, ...));
> )
>
> @script:python@
> p1 << r1.p1;
> p2 << r1.p2;
> @@
>
> print "* file: %s atomic_dec_and_test variation %s before kfree 
> variation %s" % (p1[0].file,p1[0].line,p2[0].line)
>
> However, it doesn't catch even some simple cases like for example /linux-stable/kernel/audit_tree.c:
> starting from line 109:
> static void free_chunk(struct audit_chunk *chunk) {
>     int i;
>
>     for (i = 0; i < chunk->count; i++) {
>         if (chunk->owners[i].owner)
>             put_tree(chunk->owners[i].owner);
>     }
>     kfree(chunk);
> }
>
> void audit_put_chunk(struct audit_chunk *chunk) {
>     if (atomic_long_dec_and_test(&chunk->refs))
>         free_chunk(chunk);
> }
>
> The above case is a clear kfree() call after atomic_long_dec_and_test() just via intermediate function free_chunk(). Why is it not detected?
>
> Another case:
>
> line 97:
> static inline void put_tree(struct audit_tree *tree) {
>     if (atomic_dec_and_test(&tree->count))
>         kfree_rcu(tree, head);
> }
>
> This should have been caught by fname2 at p2(a | (a, ...)) rule, but it isn't also.
>
> I have a feeling of doing smth basic wrongly...
>
> Best Regards,
> Elena.
>
