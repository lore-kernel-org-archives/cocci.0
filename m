From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 19 Nov 2014 08:08:31 +0100
Subject: [Cocci] [PATCH 1/1] kprobes: Deletion of an unnecessary check
 before the function call "module_put"
In-Reply-To: <5469B08E.90104@hitachi.com>
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
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <546899CF.8020808@users.sourceforge.net>
 <5469B08E.90104@hitachi.com>
Message-ID: <546C41EF.4040502@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> index 3995f54..f1e7d45 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1527,8 +1527,7 @@ int register_kprobe(struct kprobe *p)
>>  out:
>>  	mutex_unlock(&kprobe_mutex);
>>  
>> -	if (probed_mod)
>> -		module_put(probed_mod);
>> +	module_put(probed_mod);
> 
> This is OK, but I you request a comment line over there so that
> code reader can understand it is safe to pass a NULL pointer to
> module_put().

Do you want that I replace the shown null pointer check by a short
comment which repeats an expectation for the affected function call?

Regards,
Markus
