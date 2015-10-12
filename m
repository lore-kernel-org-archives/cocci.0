From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Mon, 12 Oct 2015 23:54:11 +0200
Subject: [Cocci] elision of unneeded parens
In-Reply-To: <CA+MoWDoJan191KVHOYvRCLGSP56co9NsfjcxCF=eLUtjUZpsGg@mail.gmail.com>
References: <CAP6exY+Mzdo=_hNUksjCfYPVKU6Fx0TgJRUZuVw8K15Y0Yo1mA@mail.gmail.com>
 <CA+MoWDp13SaQHQSCkf50WvQWMB1E3v_0kTFs94HbJ3onw4-SuA@mail.gmail.com>
 <CAP6exYLMymc3OeLMDJfvu5xkPUZe8UGRDNGfufMM-c=VUONd9A@mail.gmail.com>
 <CA+MoWDoJan191KVHOYvRCLGSP56co9NsfjcxCF=eLUtjUZpsGg@mail.gmail.com>
Message-ID: <CA+MoWDqt19jGAiiz27guRq==3gC8fF7GfdAsAKSXEjoTGk1A0Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

_very risky_:

@@
expression a, b;
@@
-(
\(a == b\|a != b\)
-)


On Mon, Oct 12, 2015 at 11:48 PM, Peter Senna Tschudin
<peter.senna@gmail.com> wrote:
> On Mon, Oct 12, 2015 at 11:45 PM, ron minnich <rminnich@gmail.com> wrote:
>> wow, I can't type.
>>
>> Let me say it more sensibly, even if wrong :-)
>> [[[ I know this is wrong, it's kind of "what I want it to do" ]]]
>>
>> @@
>> expression E1, E2;
>> statement S;
>> function f;
>> @@
>> f(...){<...
>> -if ((E1) && (E2))
>> +if (E1 && E2)
>> S
>> ...> }
>>
>> Is that any more sensible?
>
> My example adds '== d'...
>
> $ cat /tmp/test.cocci
> @@
> expression a, b, c, e;
> @@
> -((a == b) && (c != e))
> +a == b && c == d
>
> $ clear;spatch /tmp/test.cocci kernel/locking/lockdep.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> HANDLING: kernel/locking/lockdep.c
> diff =
> --- kernel/locking/lockdep.c
> +++ /tmp/cocci-output-9601-607267-lockdep.c
> @@ -1420,7 +1420,7 @@ print_shortest_lock_dependencies(struct
>   print_stack_trace(&entry->trace, 2);
>   printk("\n");
>
> - if (depth == 0 && (entry != root)) {
> + if (depth == 0 && entry == d) {
>   printk("lockdep:%s bad path found in chain graph\n", __func__);
>   break;
>   }
> @@ -2322,7 +2322,7 @@ print_irq_inversion_bug(struct task_stru
>   /* Find a middle lock (if one exists) */
>   depth = get_lock_depth(other);
>   do {
> - if (depth == 0 && (entry != root)) {
> + if (depth == 0 && entry == d) {
>   printk("lockdep:%s bad path found in chain graph\n", __func__);
>   break;
>   }
> @@ -4198,7 +4198,7 @@ retry:
>   * if it's not sleeping (or if it's not the current
>   * task):
>   */
> - if (p->state == TASK_RUNNING && p != current)
> + if (p->state == TASK_RUNNING && p == d)
>   continue;
>   if (p->lockdep_depth)
>   lockdep_print_held_locks(p);
>
> Does this help?



-- 
Peter
