From: keescook@google.com (Kees Cook)
Date: Sat, 16 Sep 2017 22:28:48 -0700
Subject: [Cocci] what is needed to match a set of fields?
In-Reply-To: <alpine.DEB.2.20.1709170724280.2252@hadrien>
References: <CAGXu5jJvY9FeyZe1stPeOaOj_h_fQuMqfKbETN4UvLHs70gQsQ@mail.gmail.com>
 <alpine.DEB.2.20.1709170724280.2252@hadrien>
Message-ID: <CAGXu5jKxC1S6sNeyihU09aE-_d+Taeg1XFdJDC3Ni9A8SXqqfg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Sep 16, 2017 at 10:25 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Sat, 16 Sep 2017, Kees Cook wrote:
>
>> Hi,
>>
>> If I have several structures inline, "identifier" doesn't match it. For example:
>>
>>         setup_timer(&priv->thermal_throttle.ct_kill_exit_tm,
>>                     iwl_tt_check_exit_ct_kill, (unsigned long)priv);
>>
>> @@
>> expression _E;
>> identifier _timer;
>> @@
>>
>> -setup_timer(&_E->_timer, ...);
>>
>> This doesn't match (which makes sense, "thermal_throttle" and
>> "ct_kill_exit_tm" are different identifiers), but I can't use an
>> expression for what's after ->. For example:
>>
>> @@
>> expression _E;
>> expression _timer;
>> @@
>>
>> -setup_timer(&_E->_timer, ...);
>>
>> This refuses to parse for me:
>>
>> Fatal error: exception Failure("minus: parse error: \n = File
>> \"/tmp/metavar.cocci\", line 6, column 18,  charpos = 59\n    around =
>> '_timer', whole content = -setup_timer(&_E->_timer, ...);\n")
>>
>> How do I match a series of identifiers? I'd like to be able to match
>> all of these with a single type of metavariable:
>>
>> setup_timer(&thing->timer, ...);
>> setup_timer(&thing->struct1.timer, ...);
>> setup_timer(&thing->struct1.struct2.timer, ...);
>> etc
>
> There is no way to do that.  Do you need to know about the names struct 1
> and struct2?

Yeah, but I'm always using them together. For example, converting
callbacks to use container_of(timer_var, struct outer, struct1.timer)

So, no worries, I'll create a separate script that adds the "struct1"
match, etc.

-Kees

-- 
Kees Cook
Pixel Security
