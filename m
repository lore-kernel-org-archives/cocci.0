From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Fri, 08 Jul 2016 15:09:44 +0300
Subject: [Cocci] Checking build dependencies for "pyml"
In-Reply-To: <trinity-c1709963-6464-4a3e-b6e2-61f43e2a05b2-1467976469248@3capp-webde-bs29>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-c1709963-6464-4a3e-b6e2-61f43e2a05b2-1467976469248@3capp-webde-bs29>
Message-ID: <ow4d1moqqk7.fsf@mbp-thierry.rsr.lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Markus:
> Has such a software evolution got any influence on the Python application
> programming interface by the semantic patch language?

The same ./spatch executable can now be run in a Python 2 and Python 3
environment (before, with Pycaml, Coccinelle had to be compiled in a
Python 2 environment to work with Python 2, and to be compiled in a
Python 3 environment to work with Python 3).

Python error handling is better as well, and the Python interface is now
only initialized when needed.

> Will the mapping (and corresponding data type conversion) will need
> another look for integer values in this use case?

The mapping is unchanged. But the better error handling should help to
debug scripts.

-- 
Thierry.

SF Markus Elfring (2016/07/08, 14:14 MSK)?:
>> Yes, the configure.ac script has been changed to handle the change from
>> Pycaml to Py.ml.
>
> Has such a software evolution got any influence on the Python application
> programming interface by the semantic patch language?
>
> Will the mapping (and corresponding data type conversion) will need
> another look for integer values in this use case?
>
> Regards,
> Markus
