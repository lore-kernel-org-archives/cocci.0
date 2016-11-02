From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 2 Nov 2016 22:09:50 +0100
Subject: [Cocci] Adding argument to a function
Message-ID: <20161102210950.GA1770@mai>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all,

I'm very new to coccinelle, so sorry if the question is irrelevant or was already asked.

I'm trying to add a new argument to a function which has a couple of callbacks.

The original function is:

static inline int cpuhp_setup_state(enum cpuhp_state state,
				    int (*startup)(unsigned int cpu),
				    int (*teardown)(unsigned int cpu));

I would like to pass a private pointer when setting the state and then pass
this pointer to the 'startup' / 'teardown' callbacks where there signature will be
different and all call sites must change their callbacks signature also.

I tried to first add the new argument to the function, in order to have:

static inline int cpuhp_setup_state(enum cpuhp_state state,
				    int (*startup)(unsigned int cpu),
				    int (*teardown)(unsigned int cpu),
				    void *data);

... with the rule:

@rule@
identifier cpuhp_setup_state;
identifier state, name, startup, teardown, data;
@@

static inline int cpuhp_setup_state(enum cpuhp_state state,
                                    const char *name,
                                    int (*startup)(unsigned int cpu),
                                    int (*teardown)(unsigned int cpu),
				    void *data)
{
	...
}

@@
identifier rule.cpuhp_setup_state;
expression E1, E2, E3, E4;
@@

cpuhp_setup_state(E1, E2, E3, E4
+                 , NULL
		 )

But the parsing gives:

...

cpuhp_setup_state(E1, E2, E3, E4
                    >>> , NULL
                  )


grep tokens
cpuhp_state || cpu
No query
warning: line 8: should cpu be a metavariable?
warning: line 9: should cpu be a metavariable?

And I don't have the expected result, well actually I have no output.

Can someone give me some hints or help to implement this change ?

Thanks in advance

  -- Daniel
