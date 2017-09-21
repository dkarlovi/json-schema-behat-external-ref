<?php

declare(strict_types=1);

namespace App\Behat;

use Behat\Gherkin\Node\PyStringNode;
use Behatch\Context\JsonContext as BaseJsonContext;
use Behatch\HttpCall\HttpCallResult;
use Behatch\HttpCall\HttpCallResultPool;

/**
 * Class JsonContext.
 */
class JsonContext extends BaseJsonContext
{
    public function __construct()
    {
        $pool = new HttpCallResultPool;

        parent::__construct($pool);
    }

    /**
     * @Given /^there is a response equal to:$/
     * @param PyStringNode $response
     */
    public function thereIsAResponseEqualTo(PyStringNode $response)
    {
        $result = new HttpCallResult($response->getRaw());
        $this->httpCallResultPool->store($result);
    }
}
