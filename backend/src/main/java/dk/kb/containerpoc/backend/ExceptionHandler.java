package dk.kb.containerpoc.backend;

import jakarta.servlet.RequestDispatcher;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ProblemDetail;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
public class ExceptionHandler extends ResponseEntityExceptionHandler {
    // Pretty much a hack to always throw status code 502 on exceptions
    @Override
    protected ResponseEntity<Object> createResponseEntity(Object body, HttpHeaders headers, HttpStatusCode statusCode, WebRequest request) {
        if (body instanceof ProblemDetail detail) {
            statusCode = HttpStatus.BAD_GATEWAY;
            detail.setStatus(statusCode.value());
            request.setAttribute(RequestDispatcher.ERROR_STATUS_CODE, HttpStatus.BAD_REQUEST.value(), RequestAttributes.SCOPE_REQUEST);
        }
        return super.createResponseEntity(body, headers, statusCode, request);
    }
}
