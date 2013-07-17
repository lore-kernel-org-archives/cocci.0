From: wagi@monom.org (Daniel Wagner)
Date: Wed, 17 Jul 2013 17:16:02 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <alpine.DEB.2.02.1307171706400.2113@hadrien>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien>
Message-ID: <51E6B532.8010909@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/17/2013 05:07 PM, Julia Lawall wrote:
> On Wed, 17 Jul 2013, Daniel Wagner wrote:
> 
>> Hi,
>>
>> I have found another small issue. Not a big thing. I have following rule
>>
>> @@
>> identifier f =~ "^(__)?connman_.*" ;
>> @@
>>
>> f(...,
>> (
>> - FALSE
>> + false
>> |
>> - TRUE
>> + true
>> )
>> ,...)
>>
>>
>> And this little C example:
>>
>> bool __connman_bar(bool baz);
>> int connman_foo(int val, bool bar);
>>
>> int main(int argc, char *argv)
>> {
>>     int err;
>>
>>     if (__connman_bar(FALSE) == TRUE)
>>         err = connman_a_rather_long_line(2434, TRUE);
>>
>>     return 0;
>> }
>>
>>
>> Running coccinelle on this results in the not so nicely formated patch:
>>
>> @@ -5,8 +5,9 @@ int main(int argc, char *argv)
>> {
>>        int err;
>>
>> -       if (__connman_bar(FALSE) == TRUE)
>> -               err = connman_a_rather_long_line(2434, TRUE);
>> +       if (__connman_bar(false) == TRUE)
>> +               err = connman_a_rather_long_line(2434,
>> +                                                                         
>> true);
>>
>>        return 0;
>> }
>>
>> When connman_a_rather_long_line() is not sooo long then it works as	
>> expected, that means not additional line is introduced. Any ideas
>> what is going wrong?
> 
> I had this problem as well.  When the line is long, it is supposed to 
> try to place the later arguments nicely.  But clearly something is going 
> wrong, and I appreciate your report, because it shows that it is not 
> just my code...
> 
> I will look at it in the next few days.

Thanks :)

Another formatting issue I found is triggered by a different rule. I figure
the expression 'E' is written out as one line and the original formatting gets
lost.

@@
expression E;
symbol TRUE;
symbol FALSE;
@@

(
- E == TRUE
+ E
|
- TRUE == E
+ E
|
- E != TRUE
+ !E
|
- TRUE != E
+ !E
|
- E == FALSE
+ !E
|
- FALSE == E
+ !E
|
- E != FALSE
+ E
|
- FALSE != E
+ E
)


the C code:


#define AGENT_INTERFACE ""

int main(int argc, char *argv[])
{
	if (g_dbus_register_interface(connection, path,
					AGENT_INTERFACE, agent_methods,
					NULL, NULL, &agent_request,
					NULL) == FALSE) {
		fprintf(stderr, "Error: Failed to register Agent callbacks\n");
                return 0;
        }

	return 0;
}


gives me this here:


int main(int argc, char *argv[])
 {
-       if (g_dbus_register_interface(connection, path,
-                                       AGENT_INTERFACE, agent_methods,
-                                       NULL, NULL, &agent_request,
-                                       NULL) == FALSE) {
+       if (!g_dbus_register_interface(connection, path, AGENT_INTERFACE, agent_methods, NULL, NULL, &agent_request, NULL)) {
                fprintf(stderr, "Error: Failed to register Agent callbacks\n");
                 return 0;
         }

cheers,
daniel
