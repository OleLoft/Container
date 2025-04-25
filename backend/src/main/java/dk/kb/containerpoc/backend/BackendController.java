package dk.kb.containerpoc.backend;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BackendController {
    private final Logger log = LoggerFactory.getLogger(BackendController.class);

    @PostMapping("/division")
    public int division(@RequestBody DivisionBody json) {
        log.info("Attempting division {}/{} {}", json.num1(), json.num2(), "(" + json.sessionId() + ")");
        return json.num1() / json.num2();
    }
}
