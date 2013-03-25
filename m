From: mstefani@redhat.com (Michael Stefaniuc)
Date: Mon, 25 Mar 2013 23:56:59 +0100
Subject: [Cocci] parameter list to expression list?
In-Reply-To: <alpine.DEB.2.02.1303252225550.2046@localhost6.localdomain6>
References: <515076A4.1030701@redhat.com>
 <alpine.DEB.2.02.1303252225550.2046@localhost6.localdomain6>
Message-ID: <5150D63B.9000806@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 03/25/2013 10:27 PM, Julia Lawall wrote:
> On Mon, 25 Mar 2013, Michael Stefaniuc wrote:
> 
>> Hello,
>>
>> is there an intrinsic way to get from a parameter list to an expression
>> list? That would come in handy when forwarding from one function to
>> another one. At the moment I help myself with a python rule that
>> transforms the parameter list to an identifier but that feels clumsy.
>> E.g. in SmPL pseudo code something like this would be nice:
>>
>> @@
>> type T;
>> parameter list P;
>> expression list E = P;
>> expression ret;
>> @@
>>  T foo(P)
>>  {
>>      return
>> -           ret
>> +           bar(E)
>>      ;
>>  }
> 
> No, there is nothing. I guess your transformation gets rid of the types in 
> the parameter list?  Perhaps what you would liek is a way to just match 
> the list of identifier parts?
Yes, something like that.
What I do now is:

@script:python new@
params << get.params;
args;
@@
import re
for p in params.elements:
    coccinelle.args += ", " + re.sub(r".* (\w+)$", r"\1", p)

thanks
bye
        michael
