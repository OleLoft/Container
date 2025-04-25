package dk.kb.containerpoc.frontend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.time.Duration;

@ConditionalOnExpression("!${app.isBFF}")
@RestController
public class FrontendController {
    private final WebClient webClient;

    @Autowired
    public FrontendController(WebClient webClient) {
        this.webClient = webClient;
    }

    @GetMapping("/division")
    public int division(@RequestParam int num1, @RequestParam int num2, @RequestParam(required = false) String sessionId) {
        Mono<Integer> result = webClient.post()
                .uri("/division")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(new DivisionBody(sessionId, num1, num2))
                .exchangeToMono(response -> {
                    if (response.statusCode().equals(HttpStatus.OK)) {
                        return response.bodyToMono(Integer.class);
                    } else {
                        return response.createException().flatMap(Mono::error); // TODO need to throw exception and use exception-handler?
                    }
                });
        return result.block(Duration.ofSeconds(30));
    }
}
