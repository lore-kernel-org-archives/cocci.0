From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Fri, 12 May 2017 14:23:26 +0200
Subject: [Cocci] howto conditional match
In-Reply-To: <alpine.DEB.2.20.1705122014540.3725@hadrien>
References: <3f759e1c-e081-910b-9012-a5d3e5902f48@broadcom.com>
 <alpine.DEB.2.20.1705122014540.3725@hadrien>
Message-ID: <10d0c253-2023-6927-3d7b-33d9d97e6496@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 5/12/2017 2:15 PM, Julia Lawall wrote:
> 
> 
> On Fri, 12 May 2017, Arend van Spriel wrote:
> 
>> I have the following rule in my cocci script. Actually, want to apply the
>> patch conditionally, ie. when type S matches one or more structure
>> definitions. Initially I had 'struct Foo *drvr, ...' but that did not work for
>> me. Any hints are appreciated.
>>
>> Regards,
>> Arend
>>
>> @@
>> identifier func;
>> identifier drvr;
>> type T;
>> expression list es;
>> type S;
>> @@
>>          T func(S *drvr, ...)
> 
> struct i *drvr, where i is an identifier metavariable?  I'm not sure what
> you mean by one or more. Do you want to match more than the first
> argument?

Hi Julia,

I mean that I want to apply the rule only if S is 'struct foo' or 
'struct bar', but not 'struct other'. Or do I need separate rules for that?

Regards,
Arend
> julia
> 
> 
>>          {
>>                  <...
>> -               brcmf_err(es);
>> +               brcmf_derr(drvr, es);
>>                  ...>
>>          }
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>
