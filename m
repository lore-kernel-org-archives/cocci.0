From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 05 Jan 2016 15:29:27 +0100
Subject: [Cocci] [PATCH v6] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <alpine.DEB.2.10.1601051512010.2521@hadrien>
References: <alpine.DEB.2.02.1512301502100.2048@localhost6.localdomain6>
 <1451893531-15817-1-git-send-email-a.hajda@samsung.com>
 <alpine.DEB.2.10.1601051512010.2521@hadrien>
Message-ID: <568BD347.7010303@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/05/2016 03:17 PM, Julia Lawall wrote:
>> + at script:python depends on org@
>> +p << r_cmp.p;
>> +e << r.e = "";
>> +@@
>> +
>> +msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
>> +coccilib.org.print_todo(p[0], msg)
>> +
>> + at script:python depends on report@
>> +p << r_cmp.p;
>> +e << r.e = "";
>> +@@
>> +
>> +msg = "WARNING: Unsigned expression compared with zero: %s" % (e)
>> +if e:
>> +    coccilib.report.print_report(p[0], msg)
> Is it intentional that these don't do the same thing?  The report case has
> an if on e, while the org case does not.  If you don't want a report when e
> doesn't have a value, you could just remove the = "" from the declaration of
> e.  That is to give a default value of e, to allow the rule to be executed
> when e doesn't have a value.
>
> julia
>
>
No, I forgot to adjust it. I will fix it then, thanks.

Regards
Andrzej
