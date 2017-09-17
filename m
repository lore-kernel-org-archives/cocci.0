From: keescook@google.com (Kees Cook)
Date: Sat, 16 Sep 2017 22:18:54 -0700
Subject: [Cocci] what is needed to match a set of fields?
Message-ID: <CAGXu5jJvY9FeyZe1stPeOaOj_h_fQuMqfKbETN4UvLHs70gQsQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

If I have several structures inline, "identifier" doesn't match it. For example:

        setup_timer(&priv->thermal_throttle.ct_kill_exit_tm,
                    iwl_tt_check_exit_ct_kill, (unsigned long)priv);

@@
expression _E;
identifier _timer;
@@

-setup_timer(&_E->_timer, ...);

This doesn't match (which makes sense, "thermal_throttle" and
"ct_kill_exit_tm" are different identifiers), but I can't use an
expression for what's after ->. For example:

@@
expression _E;
expression _timer;
@@

-setup_timer(&_E->_timer, ...);

This refuses to parse for me:

Fatal error: exception Failure("minus: parse error: \n = File
\"/tmp/metavar.cocci\", line 6, column 18,  charpos = 59\n    around =
'_timer', whole content = -setup_timer(&_E->_timer, ...);\n")

How do I match a series of identifiers? I'd like to be able to match
all of these with a single type of metavariable:

setup_timer(&thing->timer, ...);
setup_timer(&thing->struct1.timer, ...);
setup_timer(&thing->struct1.struct2.timer, ...);
etc

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
