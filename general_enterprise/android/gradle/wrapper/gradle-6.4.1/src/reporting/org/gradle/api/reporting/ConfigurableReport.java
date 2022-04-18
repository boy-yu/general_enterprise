/*
 * Copyright 2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.api.reporting;

import org.gradle.api.provider.Provider;

import java.io.File;

/**
 * A file based report to be created with a configurable destination.
 */
public interface ConfigurableReport extends Report {

    /**
     * Whether or not this report should be generated by whatever generates it.
     *
     * @see #isEnabled()
     * @param enabled Whether or not this report should be generated by whatever generates it.
     * @since 4.0
     */
    @Override
    void setEnabled(boolean enabled);

    /**
     * Whether or not this report should be generated by whatever generates it.
     *
     * @see #isEnabled()
     * @param enabled Provider for indicating whether or not this report should be generated by whatever generates it.
     * @since 4.0
     */
    void setEnabled(Provider<Boolean> enabled);

    /**
     * Sets the destination for the report.
     *
     * @param file The destination for the report.
     * @see #getDestination()
     * @since 4.0
     */
    void setDestination(File file);

    /**
     * Sets the destination for the report.
     *
     * @param provider The provider of the destination for the report.
     * @see #getDestination()
     * @since 4.0
     */
    void setDestination(Provider<File> provider);
}
