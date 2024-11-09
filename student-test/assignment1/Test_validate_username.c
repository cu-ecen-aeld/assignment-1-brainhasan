#include "unity.h"
#include <stdbool.h>
#include <stdlib.h>
#include "../../examples/autotest-validate/autotest-validate.h"
#include "../../assignment-autotest/test/assignment1/username-from-conf-file.h"

/**
* This function should:
*   1) Call the my_username() function in autotest-validate.c to get your hard coded username.
*   2) Obtain the value returned from function malloc_username_from_conf_file() in username-from-conf-file.h within
*       the assignment autotest submodule at assignment-autotest/test/assignment1/
*   3) Use unity assertion TEST_ASSERT_EQUAL_STRING_MESSAGE to verify the two strings are equal.  See
*       the [unity assertion reference](https://github.com/ThrowTheSwitch/Unity/blob/master/docs/UnityAssertionsReference.md)
*/
void test_validate_my_username()
{
     const char* hardcoded_username = my_username();
    
    // 2. Username loaded from the configuration file
    char* config_username = malloc_username_from_conf_file();

    // 3. Assert that both usernames match
    TEST_ASSERT_EQUAL_STRING_MESSAGE(
        hardcoded_username, 
        config_username, 
        "The username from my_username() does not match the username in the config file."
    );

    // 4. Free dynamically allocated memory
    free(config_username);
    
}