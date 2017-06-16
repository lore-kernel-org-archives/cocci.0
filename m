From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Fri, 16 Jun 2017 13:29:55 +0200
Subject: [Cocci] matching variations of function result check
In-Reply-To: <alpine.DEB.2.20.1706161142150.3029@hadrien>
References: <386ba17e-4cd7-9248-3304-e1809a65fffa@broadcom.com>
 <CA+MoWDoa1w=p638w-h0U4OPCUMHXqiZpLHpMpu8RekR5KtbyaA@mail.gmail.com>
 <alpine.DEB.2.20.1706161142150.3029@hadrien>
Message-ID: <69b2d987-dabd-5add-ecb7-fbf2a88c83d8@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 6/16/2017 11:47 AM, Julia Lawall wrote:
> 
> 
> On Fri, 16 Jun 2017, Peter Senna Tschudin wrote:
> 
>> Hi Arend,
>>
>> Check these examples of using '... when':
>>
>> https://github.com/coccinelle/coccinellery/search?utf8=%E2%9C%93&q=when&type=
>>
>> I guess this can be helpful
>>
>>
>>
>> On Fri, Jun 16, 2017 at 11:01 AM, Arend van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>>> I am trying to write a cocci script as below:
>>>
>>> @@
>>> identifier NDEV;
>>> int RES;
>>> @@
>>>
>>>   RES = register_netdevice(NDEV);
>>>   if (RES) {
>>>          <...
>>> -       free_netdev(NDEV);
>>> +       foo(NDEV);
>>> +       free_netdev(NDEV);
> 
> You can just put +foo(NDEV) in front of the existing call to free_netdev,
> rather that removing the call to free_netdev and adding it back.

I tried that, but spatch complaint so I tried this and it worked. Not 
sure what spatch version I used as I was working on another machine.

>>>          ...>
>>>   }
>>>
>>> However, I want to catch more variations, ie.
>>>
>>>          if (RES < 0)
>>>          if (RES != 0)
> 
> Perhaps you don't care much about how RES is tested?  You can try
> 
> if (<+...RES...+>)
> 
> which will match a case with any reference to RES in the if test.  This
> could give false positives, if RES is used in some other way, but it could
> be worth trying.

Assuming the if statement after calling register_netdevice handles the 
error path, which is probably true if it contains the free_netdev() 
call. So yeah, it is worth trying. Thanks for the suggestion.

>>>          if (register_netdevice(NDEV) < 0)
> 
> For this, you would need a separate pattern.  Coccinelle doesn't do any
> dataflow analysis that would detect that naming the result of the call and
> then testing the name is the same as simply tsting the call.

Too bad. Still a great tool ;-)

>>>
>>> and so on. To boot the function call may either be register_netdevice or
>>> register_netdev.
> 
> You can put a disjunction: \(fn1\|fn2\).  Another option is to make an
> identifier metavariable with an appropriate regular expression, but this
> would be less efficient than the disjuction option.  Coccinelle does some
> optimizations based on what is the pattern matching code, but not regular
> expression constraints.

Will try that.

Thanks,
Arend
