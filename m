From: markus.heiser@darmarit.de (Markus Heiser)
Date: Fri, 5 Jan 2018 17:05:57 +0100
Subject: [Cocci] [PATCH v3 1/1] runchecks: Generalize make C={1,
 2} to support multiple checkers
In-Reply-To: <87vagg8jjw.fsf@intel.com>
References: <cover.5b56d020b8e826a7da33b1823c059acd0c123f8b.1515072782.git-series.knut.omang@oracle.com>
 <5f292b7effba0efcf4855bff83b7b9313ac45895.1515072782.git-series.knut.omang@oracle.com>
 <874lo1aait.fsf@intel.com> <1515096931.31439.647.camel@oracle.com>
 <87vagg8jjw.fsf@intel.com>
Message-ID: <3713CA61-B267-44FF-BF58-91F13CB4F915@darmarit.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> Am 05.01.2018 um 15:30 schrieb Jani Nikula <jani.nikula@linux.intel.com>:
> 
> On Thu, 04 Jan 2018, Knut Omang <knut.omang@oracle.com> wrote:
>> On Thu, 2018-01-04 at 17:50 +0200, Jani Nikula wrote:

[...]

>> Hmm - I have been burnt by the use of unstable interfaces in Python before,
>> when I needed it to work on a (Linux) system with Python v.2.6.x only
>> - argparse was introduced in v.2.7. and alternative choices are not 
>> at all clear to me, see for instance:
>> 
>>  https://dmerej.info/blog/post/docopt-v-argparse/
>> 
>> If this program was part of a "standalone" python project with a well defined python
>> environment, I would probably have used argparse, which I have used in other projects.
>> 
>> In fact I hesitated even to use python for this, because of fear of versioning issues..
>> When I was tempted anyway, and after looking at the existing examples in scripts/ 
>> ruling out python v.3.x, it felt safer to stay with the bare minimum of module 
>> features for this simple logic.
>> 
>> I do feel confident that the benefits of python for this outweighs the drawbacks
>> compared to my initial shell script implementation, or using perl or even C.
>> 
>> Further advice on this appreciated,
> 
> Again, I can only offer my opinion of requiring Python v2.7 and using
> argparse, but it doesn't carry much weight. Up to the kbuild
> maintainers.

FYI: Py2.6 support has ended and Py2 expected to be end in 2020, the
countdown is running ;)

  https://pythonclock.org/

If you wan't a command-line parser which is "builtin" use argparse,
this is what I do mostly. If you are able to use requirements from
outside use click [1]. For more infos read e.g. [2]. Docopt [3] has
its charm but I would prefer the decorators from click.

[1] http://click.pocoo.org/5/
[2] https://realpython.com/blog/python/comparing-python-command-line-parsing-libraries-argparse-docopt-click/
[3] https://github.com/docopt

-- Markus --
